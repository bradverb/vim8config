# vim8config

To download on a new device (note the dot so it doesn't clone the top level dir):
```
cd ~/<vim directory>
git clone --recursive https://github.com/bradverb/vim8config .
```

To update submodules/packages (first line required for first pull to new device):  
```
git submodule init
git submodule update --remote --merge
git commit
```

To add a new submodule (ignore = all recommended but not 100% necessary)
```
git submodule add <package-repo> pack/bradverb/<start-OR-opt>/<package-name>
echo "        ignore = all" >> .gitmodules
git add .gitmodules
git commit -m "Added <package> to submodules"
```

To update helptags after adding new package:  
```
vim -u NONE -c 'helptags <path/to/package>/doc' -c q
```
To update all help tags in the pack folder (run as vim script):
```
for d in split(globpath('<vim-directory>/pack/', '**/doc'), '\n')
        execute 'helptags ' . d
        echo 'Finished tagging ' . d
endfor
```

To remove a submodule/package:  
```
git submodule deinit pack/bradverb/<...>
git rm pack/bradverb/<...>
<delete the actual package folder>
git commit
```
