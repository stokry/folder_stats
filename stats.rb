require 'csv'
require 'fileutils'

def analyze_folder(folder_path)
  csv_file_path = File.join(Dir.pwd, 'folder_stats.csv')

  CSV.open(csv_file_path, 'w') do |csv|
    csv << ['Name', 'Type', 'Size (bytes)', 'Date Modified']

    Dir.foreach(folder_path) do |filename|
      next if filename == '.' || filename == '..'

      file_path = File.join(folder_path, filename)
      file_type = File.directory?(file_path) ? 'Folder' : 'File'
      file_size = File.size(file_path)
      file_modified = File.mtime(file_path)

      csv << [filename, file_type, file_size, file_modified]
    end
  end

  puts "Folder statistics saved to #{csv_file_path}."
end

print 'Enter the folder path: '
folder_path = gets.chomp

if Dir.exist?(folder_path)
  analyze_folder(folder_path)
else
  puts "Folder does not exist."
end
