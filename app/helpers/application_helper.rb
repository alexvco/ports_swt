module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        "alert-info"
    end
  end

  def create_json_tree(stack_word_tree)
    tree = { name: "flare", children: [] }
    stack_word_tree.result.each do |result|
      tree[:children] << { name: result, size: result.length }
    end
    tree
  end
end
