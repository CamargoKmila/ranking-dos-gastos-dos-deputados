require 'rails_helper'

RSpec.describe Dashboard::UploadCsv do
  let(:csv_path) { Rails.root.join('spec', 'fixtures', 'files', 'deputies.csv') }
  let(:csv_file) { fixture_file_upload(csv_path, 'text/csv') }

  subject { described_class.new(csv_file) }

  describe '#call' do
    context 'when the file is valid' do
      it 'import data successfully' do
        result = subject.call

        expect(result).to be true
        expect(subject.imported_rows).to be > 0
        expect(subject.errors).to be_empty

        expect(Deputy.count).to be > 0
        expect(Cost.count).to be > 0
      end

      it 'imports only rows matching the FILTER_UF' do
        subject.call
    
        imported_ufs = Deputy.pluck(:sgUF).uniq
        expect(imported_ufs).to eq([Dashboard::UploadCsv::FILTER_UF])
      end

      it 'does not create duplicate deputies for multiple rows of the same deputy' do
        csv_path = Rails.root.join('spec', 'fixtures', 'files', 'costs_same_deputy.csv')
        csv_file = fixture_file_upload(csv_path, 'text/csv')
        service = described_class.new(csv_file)

        expect {
          service.call
        }.to change(Deputy, :count).by(1)
         .and change(Cost, :count).by(3) # Ajuste o número conforme seu CSV de teste
      end
    end

    context 'when the file is not CSV' do
      let(:csv_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'not_csv.txt'), 'text/plain') }

      it 'returns false and adds error' do
        result = subject.call

        expect(result).to be false
        expect(subject.errors.first[:error]).to match(/Arquivo não é um CSV válido/)
      end
    end

    context 'when there is a validation error on a line' do
      let(:csv_path) { Rails.root.join('spec', 'fixtures', 'files', 'deputies_with_errors.csv') }
      let(:csv_file) { fixture_file_upload(csv_path, 'text/csv') }

      it 'keeps importing and logs error' do
        result = subject.call

        expect(result).to be false
        expect(subject.imported_rows).to be > 0
        expect(subject.errors).not_to be_empty

        expect(subject.errors.first[:error]).to match(/Validation failed/)
      end
    end

    context 'when a row has an invalid date format' do
      let(:csv_path) { Rails.root.join('spec', 'fixtures', 'files', 'deputies_with_invalid_date.csv') }
      let(:csv_file) { fixture_file_upload(csv_path, 'text/csv') }

      it 'logs the error but continues processing the file' do
        result = subject.call

        expect(result).to be false
        expect(subject.errors.first[:error]).to match(/can't be blank/i)
      end
    end
  end
end
