ex: a.color(:red)

property received is "color"
value received is: "red" 

if nil => the method become a getter 
ex : a.color => {value :red}

else : 
 the methods chain the following treatment : 

1- Check if property received is an Array to sanitize (add an automatically generated id to the value hash if not supply by the user )
1- Add the property and its value to the history Array
1- send the value in the pre-processor if needed
1- store the property/value key pair in class variable
1- send the value in the processor if needed
1- send property/value key pair to the renderer
1- format the return value differently it the atome is a property or a whole atome 
