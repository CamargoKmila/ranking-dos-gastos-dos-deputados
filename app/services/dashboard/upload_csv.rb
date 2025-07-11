# frozen_string_literal: true

require 'csv'

module Dashboard
  class UploadCsv
    attr_reader :csv, :imported_rows, :errors

    FILTER_UF = 'SP'.freeze

    def initialize(csv)
      @csv = csv
      @imported_rows = 0
      @errors = []
      @deputies_cache = {}
    end

    def self.call(csv)
      new(csv).call
    end

    def call
      Rails.logger.info "Iniciando importação do CSV: #{csv.inspect}"
      validate_file!

      ActiveRecord::Base.transaction do
        CSV.foreach(csv.path, headers: true, encoding: 'bom|utf-8', col_sep: ';') do |row|
          next unless filter_row?(row)
        
          deputy = find_or_create_cached_deputy!(row)
          create_cost!(row, deputy)
          @imported_rows += 1
        end
      end

      errors.empty?
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Erro de ActiveRecord: #{e.message}"
      @errors << { error: e.message }
      false
    rescue StandardError => e
      Rails.logger.error "Erro de ActiveRecord: #{e.message}"
      @errors << { error: e.message }
      false
    end
    
    private

    def validate_file!
      content_type_valid = csv.respond_to?(:content_type) && csv.content_type == 'text/csv'
      path_valid = csv.respond_to?(:path) && File.extname(csv.path) == '.csv'

      unless content_type_valid || path_valid
        raise ArgumentError, 'Arquivo não é um CSV válido'
      end
    end

    def filter_row?(row)
      row['sgUF'] == FILTER_UF
    end

    def find_or_create_cached_deputy!(row)
      key = "#{row['txNomeParlamentar']}_#{row['ideCadastro']}_#{row['cpf']}"
    
      @deputies_cache[key] ||= Deputy.find_or_create_by!(
        txNomeParlamentar: row['txNomeParlamentar'],
        ideCadastro: row['ideCadastro'],
        nuCarteiraParlamentar: row['nuCarteiraParlamentar'],
        cpf: row['cpf'],
        sgUF: row['sgUF'],
        sgPartido: row['sgPartido']
      )
    end

    def create_cost!(row, deputy)
      Cost.find_or_create_by!(
        txtDescricao: row['txtDescricao'],
        txtFornecedor: row['txtFornecedor'],
        txtCNPJCPF: row['txtCNPJCPF'],
        datEmissao: parse_date(row['datEmissao']),
        vlrLiquido: row['vlrLiquido'],
        urlDocumento: row['urlDocumento'],
        deputy: deputy
      )
    end

    def parse_date(date_string)
      return if date_string.blank?

      DateTime.parse(date_string) rescue nil
    end
  end
end
