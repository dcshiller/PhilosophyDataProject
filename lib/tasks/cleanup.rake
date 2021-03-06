namespace :cleanup do
  task remove_nil_authors: :environment do
    AuthorCleaner.delete_nils!
  end

  task copy_display_names: :environment do
    Publication.find_each do |pub|
      pub.display_title = pub.title&.chomp(".")
      pub.save
    end
  end
end
