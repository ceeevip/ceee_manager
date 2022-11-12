

void  getPathWidge(String path){
  List dirs = [];
  while(true){
    int index = path.lastIndexOf("/");
    if(index ==-1){
      break;
    }
    if(index ==0){
      dirs.insert(0,"/");
      break;
    }
    dirs.insert(0,path.substring(0,index));
    path = path.substring(0,index);
  }
  for (var value in dirs) {
    print(value);
  }

}

String pathname(String path){
  int index  = path.lastIndexOf("/");
  if(index ==-1 || path.length==1){
    return "/";
  }
  return path.substring(index+1);
}

void main(){
  // getPathWidge("/aaa/bbb/ccc/ddd");
  // var s = pathname("/aaa/bbb/ccc/ddd");
  var s = pathname("/aa/dd");
  print(s);
}