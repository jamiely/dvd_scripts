#!/usr/bin/env ruby

require 'erb'
require 'tempfile'

class Program
  def get_file_paths
    files = ARGV.map do | file |
      File.absolute_path file
    end.select do | file |
      File.exists? file
    end.select do | file |
      file.end_with? ".mpg"
    end

    files
  end
  def get_xml_contents(file_paths)
    <<-HEREDOC
    <dvdauthor>
      <vmgm />
      <titleset>
        <titles>
          <pgc><% files.each do |file| %>
            <vob file="<%= file %>" /><% end %>
          </pgc>
        </titles>
      </titleset>
    </dvdauthor>
    HEREDOC
  end
  def write_dvdauthor_xmlfile!(files)
    template = ERB.new get_xml_contents(files)
    xml_path = tempfile('dvdauthor.xml')
    File.open(xml_path, 'w') do | xml_file |
      xml_file.write(template.result(binding))
    end
    xml_path
  end
  def write(files)
    xmlfile = write_dvdauthor_xmlfile!(files)
    return if xmlfile.nil?
    puts xmlfile
  end
  def run!
    files = get_file_paths
    write(files)
  end

  private 
  def tempfile(prefix)
    File.expand_path(Dir::Tmpname.make_tmpname(prefix, nil), Dir::Tmpname.tmpdir)
  end
end

Program.new.run!

