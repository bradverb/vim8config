# vim8config

To download on a new device (note the dot so it doesn't clone the top level dir):
```
cd ~/<vim directory>
git clone --recursive https://github.com/bradverb/vim8config .
```

To update submodules/packages:  
```
git submodule update --remote --merge
git commit
```

To add a new submodule:
```
git submodule add <package-repo> pack/bradverb/<start-OR-opt>/<package-name>
git add .
git commit -m "Added <package> to submodules"
```

To update helptags after adding new package:  
```
vim -u NONE -c 'helptags <path/to/package>/doc' -c q
```

To remove a submodule/package:  
```
git submodule deinit pack/bradverb/<...>
git rm pack/bradverb/<...>
<delete the actual package folder>
git commit
```
