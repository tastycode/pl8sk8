task :plate_scan => :environment do
  Resque.enqueue(Jobs::ScanAllPlates)
end

