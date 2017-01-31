class Journal < ActiveRecord::Base
  has_many :publications
  has_many :authors, through: :publications

  scope :philosophy, -> { where(philosophy: true)} 

  
  def self.condensed_name(name)
    cn = name.remove("The ", "A ", "'")
    cn = cn.split(":").first
    cn = cn.split("- ").first
    cn = cn.gsub("  ", " ")
    cn = cn.strip
  end

  def co_publication_percentage(other_journal)
    authors_count = authors.count
    other_authors_count = other_journal.authors.count
    # co_pub_ids = authors.merge(Author.group(:id).where("COUNT(authorships.id) > 5").pluck(:id) & other_journal.authors.pluck(:id)
    co_pub_ids = authors.merge(Author.having_five_pubs).pluck(:id) & other_journal.authors.pluck(:id)
    co_pub_authors_count = co_pub_ids.count
    (co_pub_authors_count.to_f * 100 / [authors_count, other_authors_count].min).round(2)
  end
end