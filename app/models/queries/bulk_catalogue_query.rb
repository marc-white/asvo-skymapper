require 'csv'

class BulkCatalogueQuery < Query

  PARAMETER_FIELDS = [:file, :sr]

  attr_accessor *PARAMETER_FIELDS

  validates :file, presence: true
  validates :sr, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }, format: { with: /^-?\d*(\.\d{1,8})?$/, message: 'must be a number with 8 decimal places' }
  validate :file, :valid_search_file

  before_validation :clean_values

  def valid_search_file
    if file and File.file? file
      csv = CSV.parse(File.read(file))
      if csv.empty?
        errors.add(:file, 'must not be empty')
      else
        csv.each_with_index do |row, index|
          query_args = { sr: sr }
          query_args[:ra] = row[0] if row[0]
          query_args[:dec] = row[1] if row[1]
          query = PointQuery.new(query_args)
          unless query.valid?
            query.errors.messages[:ra].each { |error| errors.add(:file, "Line #{index + 1}: Right ascension #{error}") } if query.errors.messages[:ra]
            query.errors.messages[:dec].each { |error| errors.add(:file, "Line #{index + 1}: Declination #{error}") } if query.errors.messages[:dec]
          end
        end
      end
    else
      errors.add(:file, 'must be a file')
    end
  end

  def all_fields
    PARAMETER_FIELDS
  end

end