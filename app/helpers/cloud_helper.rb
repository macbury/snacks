module CloudHelper
  def tag_cloud(tags,classes=%w( tag1 tag2 tag3 tag4 tag5 tag6 tag7 tag8 tag9 ))
    tags_val = tags.map(&:tag_count)
    max = tags_val.max.to_i
    min = tags_val.min.to_i

    div = ((max - min) / classes.size) + 1
    
    tags.each do |tag|
      yield tag, classes[(tag.tag_count.to_i - min) / div]
    end
  end
end