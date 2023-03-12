import os
import commands
import term

fn main() {
	mut json_map := map[string]string{}

	for {
		println('Enter a command (type "help" to see available commands, type "exit" to exit the program)')
		tokens := os.input(term.bright_yellow("> ")).split(' ')

		match tokens[0] {
			"exit" {
				return
			}
			"help" {
				commands.help()
			}
			"create" {
				if tokens.len != 2 {
					println('${term.red("Incorrect number of arguments!")} Expected 1 argument (the name of the json data variable)\n')
					continue
				}

				commands.create(mut json_map, tokens[1])
			}
			"remove" {
				if tokens.len != 2 {
					println('${term.red("Incorrect number of arguments!")} Expected 1 argument (the name of the json data variable)\n')
					continue
				}	
				
				commands.remove(mut json_map, tokens[1])
			}
			"view" {
				commands.view(json_map)
			}
			"post" {
				if tokens.len != 3 {
					println('${term.red("Incorrect number of arguments!")} Expected 2 arguments (the url and the name of the json data variable)\n')
					continue
				}

				commands.post(tokens[1], json_map, tokens[2])
			}
			"get" {
				if tokens.len != 2 {
					println('${term.red("Incorrect number of arguments!")} Expected 1 arguments (the url)\n')
					continue
				}

				commands.get(tokens[1])
			}
			else {
				println('${term.red("Unknown command:")} "${tokens[0]}"')
			}
		}

		println('') // new line before next prompt
	}
}