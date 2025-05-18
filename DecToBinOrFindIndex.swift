//
// DecToBinOrFindIndex.swift
//
// Created by Noah Smith
// Created on 2025-05-10
// Version 1.0
// Copyright (c) 2025 Noah Smith. All rights reserved.
//

// The DecToBinOrFindIndex.swift is 2 programs in one.
// The user can choose the one they want to try.
// The first program takes an integer and returns its value in binary.
// The second program returns the index of the first occurrence of aChar in someString
// Both programs read from an input file and write the results to an output file.
// The program will keep looping until the user presses 'q' to quit.

import Foundation

// Function to convert decimal to binary
func decToBin(_ intNum: Int) -> String {
    // Base case
    if intNum < 2 {

        // If the number is 0 or 1, return it as a string
        return String(intNum)
    } else {
        // Recursive case
        // Call the function recursively with the number divided by 2
        // and add the remainder to the end of the string
        // source: https://docs.vultr.com/python/examples...
        //.../convert-decimal-to-binary-using-recursion
        return decToBin(intNum / 2) + String(intNum % 2)
    }
}

// Function to find the index of a character in a string
func findIndex(_ string: String, _ aChar: Character) -> Int {
    // Base cases
    // If the string is empty
    if string.isEmpty {

        // Return -1
        return -1
    
    // If the first character of the string is the character
    } else if string.first == aChar {

        // Return 0
        return 0

    } else {
        // Recursive case
        // Call the function recursively with the string without the first character
        // source: https://developer.apple.com/documentation/swift/string/dropfirst(_:)
        let nextIndex = findIndex(String(string.dropFirst()), aChar)

        // If the character is not found
        if nextIndex == -1 {

            // return -1
            return -1
        
        // If the character is found
        } else {

            // Return the index + 1,
            // Since we removed the first character with .dropFirst(),
            // we need to add 1 to the index to get the correct index
            return nextIndex + 1
        }
    }
}

// initialize user's choice
var choice: String = ""

// Loop until user enters 'q'
repeat {
    // List the options for the user
    print("Press 1 to convert decimal to binary")
    print("Press 2 to find the index of a character")
    print("Press q to quit")

    // Get user's choice
    // ?? is for a default value if choice is nil
    choice = readLine() ?? ""

    // if the user enters 'q'
    if choice == "q" {
        // Display a goodbye message
        print("Goodbye!")

    // if the user enters 1
    } else if choice == "1" {

        // Try to read input from the file
        do {

            // Get the input and output file paths
            let inputPath = "decToBinInput.txt"
            let outputPath = "decToBinOutput.txt"

            // Read input file
            let inputContent = try String(contentsOfFile: inputPath)

            // Split the file into lines
            let lines = inputContent.components(separatedBy: .newlines)

            // Initialize the output string
            var output = ""

            // Loop through each line
            for line in lines {

                // try to convert the line to an integer
                if let intNum = Int(line) {

                    // If the integer is 0
                    if intNum < 0 {

                        // add a message to the output string
                        output += "'\(line)' is negative.\n"
                    } else {

                        // Call the decToBin function to convert the integer to binary
                        let binary = decToBin(intNum)

                        // Add the binary message to the output string
                        output += "\(intNum) is \(binary) in binary.\n"
                    }
                
                // If the line is not a valid integer
                } else {

                    // Add an error message to the output string
                    output += "'\(line)' is not a valid integer.\n"
                }
            }

            // Write the output to the output file once it has iterated through all lines
            // Got this from the course website
            try output.write(toFile: outputPath, atomically: true, encoding: .utf8)

            // Display a success message
            print("Successfully written to '\(outputPath)'")

        // If there is a file error
        } catch {

            // Display a file error message
            print("Unable to write to 'decToBinOutput.txt'.")
        }

    // If the user enters 2
    } else if choice == "2" {

        // Try to read input from the file
        do {

            // Get the input and output file paths
            let inputPath = "findIndexInput.txt"
            let outputPath = "findIndexOutput.txt"

            // Get the character to find from the user
            print("Enter a character to find in the string: ")

            // Read user input and ensure it's a single character
            if let input = readLine(), input.count == 1, let aChar = input.first {

                // Store input file as one variable
                let inputContent = try String(contentsOfFile: inputPath)

                // Split the file into lines
                let lines = inputContent.components(separatedBy: .newlines)

                // Initialize the output string
                var output = ""

                // Loop through each line
                for line in lines {

                    // function call to get the index of aChar in line
                    let index = findIndex(line, aChar)

                    // If the index is -1, it means the character was not found
                    if index == -1 {

                        // Add a char not found message to the output string
                        output += "'\(aChar)' is not found in '\(line)'.\n"
                    } else {
                        // Add a message saying what index the char is found at to the output string
                        output += "'\(aChar)' is first found at index \(index) of '\(line)'\n"
                    }
                }

                // Write the output to the output file once it has iterated through all lines
                try output.write(toFile: outputPath, atomically: true, encoding: .utf8)

                // Display a success message
                print("Successfully written to '\(outputPath)'")

            } else {
                // Display an error message
                print("Invalid character input.")
            }
        } catch {
            // Display a file error message
            print("Unable to write to 'findIndexOutput.txt'.")
        }

    // If the user enters an invalid choice
    } else {
        // Display an error message
        print("Invalid choice. Please try again.")
    }

// End the loop when the user enters 'q'
} while choice != "q"
