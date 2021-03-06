git --no-pager log --author="$1" --since="0am" > log.txt

python - << EOF
import re
first_message_index = 4
step_index = 6
def get_first_alphabetic_character_pos(s):
    m = re.search(r'[a-z]', s, re.I)
    if m is not None:
        return m.start()
    return 0
with open('log.txt') as f:
    lines = f.readlines()
desired_lines = lines[first_message_index::step_index]
formatted_list = list()
for line in desired_lines:
    stripped = line.strip()
    start_pos = get_first_alphabetic_character_pos(stripped)
    without_ticket_no = stripped[start_pos::]
    capitalizedFirstLetter = without_ticket_no[0].capitalize()
    formatted_line = capitalizedFirstLetter + without_ticket_no[1::]
    formatted_list.append(formatted_line)
formatted_list.reverse()
single_string = ". ".join(formatted_list)
single_string = single_string + "."
f = open("formatted.txt", "w")
f.write(single_string)
f.close()
EOF
pbcopy < formatted.txt
rm log.txt
rm formatted.txt
echo "formatted logs were copied to the clipboard!"
