module commands

import os
import net.http
import term

pub fn help() {
	println("Commands: ")
	println('${term.bright_yellow("create")}\t[Creates a json data variable] ex: "create my_data"')
	println('${term.bright_yellow("view")}\t[Displays json variables created with the "create" command]')
	println('${term.bright_yellow("post")}\t[Sends an http post request] ex: "post http://example.com my_data"')
	println('${term.bright_yellow("get")}\t[Sends an http get request] ex: "get http://example.com"')
	println('${term.bright_yellow("exit")}\t[Exits the program]')
}

pub fn create(mut json_map map[string]string, var_name string) {
	data := os.input("Input the json data: ")	
	json_map[var_name] = data 
}

pub fn remove(mut json_map map[string]string, var_name string) {
	if json_map.len == 0 {
		println('You have no variables saved. Use the ${term.bright_yellow("create")} command to create a json variable.')
		return
	}

	if var_name !in json_map.keys() {
		println('"$var_name" is not a saved variable. Use the ${term.bright_yellow("view")} command to view saved variables.')
		return
	}

	json_map.delete(var_name)
	println("Removed $var_name from saved variables.")
}

pub fn view(json_map map[string]string) {
	// todo: figure out how to pretty print the json data
	if json_map.len == 0 {
		println('You have no variables saved. Use the ${term.bright_yellow("create")} command to create a json variable.')
		return
	} 

	for key, value in json_map { 
		key_colorized := term.hex(0x3ddad2, key)
		val_colorized := term.hex(0xf29db3, value)
		println("${key_colorized:-29} = $val_colorized") 
	}
}

pub fn post(url string, json_map map[string]string, key string) {
	if key !in json_map.keys() {
		println('"$key" is not a saved variable. Use the ${term.bright_yellow("view")} command to view saved variables.')
		return
	}

	res := http.post_json(url, json_map[key]) or {
		println(err)
		return
	} 
	
	// todo: maybe colorize the different keys of the response
	println('${term.blue("Status:")} $res.status_code $res.status_msg')
	println('${term.magenta("Body:")} \n$res.body')
}

pub fn get(url string) {
	res := http.get(url) or {
		println(err)
		return
	}

	println('${term.blue("Status:")} $res.status_code $res.status_msg')
	println('${term.magenta("Body:")} \n$res.body')
}