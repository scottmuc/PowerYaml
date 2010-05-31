PowerYaml
=========

PowerYaml is a wrapper around [Yaml.Net][] library which is the best .Net Yaml parser I've found so far.

Sample
------

*sample.yml*

	parent: 
	  child:
		a: a value
		b: b value
		c: c value
	  child2: 
		key4: value 4
		key5: value 5

And here's the parsing of the above yaml		
		
	PS C:\dev\PowerYaml> & .\Examples\sample.ps1
	Attempting to call Get-YamlNameValues

	Name                           Value
	----                           -----
	a                              a value
	b                              b value
	c                              c value

[Yaml.Net]: http://sourceforge.net/projects/yamldotnet/ "Yaml.Net"