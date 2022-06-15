
<span align="right">

[Main menu](../atome.md)
-
</span>


**How to build ans publish the gem**
-

Build
-

At the root of the gem folder type:

         gem build 

Install 
-

At the root of the gem folder type:

         gem install atome 

publish
-

At the root of the gem folder, assuming you've just build the 1.01 version of atome and you have a rubygems account (https://rubygems.org), type:

         gem push atome-1.01.gem 

**[- What's in the box](./box_content.md)**
-

Guideline and philosophy
-

to keep this concept working we must follow the following rules during atome development :

- All Apis must run of all targeted platform (their should be no difference from one platform to another.)
- Any property or new api must always work on any type of atome, to keep the consistency of the "atome uniq object"


**[- atome explained](./atome_explained.md)**
-

**[- Architecture of the folders](./folder_architecture.md)**
-

**[- logic and datas flows](./datas_flows.md)**
-