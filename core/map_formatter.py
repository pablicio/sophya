import os, json, re

def validFiles(str, regex):
    # Compile the ReGex
    p = re.compile(regex)
 
    # If the string is empty
    # return false
    if (str == None):
        return False
 
    # Return if the string
    # matched the ReGex
    if(re.search(p, str)):
        return True
    else:
        return False

def titleize(sentence, separator):
    new_sentence = []
    for word in sentence.split(separator):
      new_sentence.append(word.capitalize())

    return ' '.join(new_sentence)


def list_files(startpath):
    for root, dirs, files in os.walk(startpath):
        dir_content = []
        for dir in dirs:
            go_inside = os.path.join(startpath, dir)
            dir_content.append(list_files(go_inside))

        files_lst = []
        md_name = ''
        md_slug = ''

        for f in files:
            # Regex to check valid files extension.
            if validFiles(f, "([^\\s]+(\\.(?i)(puml|png|md|json))$)"):
              files_lst.append(f)

            # Regex to get principal md from dir.
            if validFiles(f, "([^\\s]+(\\.(?i)(md))$)"):
              md_name = titleize(f[:-3], "-")
              md_slug = f

        return {
          'path': root[1:],
          'files': files_lst,
          'items': dir_content,
          'name': md_name,
          'md_slug': md_slug
        }

output = list_files('.')

# Convert the data to a JSON formatted string with 4 spaces of indentation
json_str = json.dumps(output["items"], indent=2)

# Print the pretty-printed JSON string
print(json_str)