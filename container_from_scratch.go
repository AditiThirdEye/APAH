package main
import (
    "os"
    "os/exec"
    "fmt"
    "syscall"
    "path/filepath"
    "strconv"
    "io/ioutil"
)
func main() {
    switch os.Args[1] {
    case "run":
        run()
    case "ns":
        ns()
    default:
        panic("pass me an argument please")
    }
}
func run() {
    fmt.Printf("Running %v as %d\n" ,os.Args[2:], os.Getpid())     
    cmd := exec.Command("/proc/self/exe" , append([]string{"ns"}, os.Args[2:]...)...)
    cmd.Stdin = os.Stdin
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr     
    cmd.SysProcAttr = &syscall.SysProcAttr {
       Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS,
       Unshareflags: syscall.CLONE_NEWNS,
    }
    cmd.Run()
}
func ns() {
   fmt.Printf("Running in new UTS namespace %v as %d\n" ,os.Args[2:], os.Getpid())
  
   cg()    
   syscall.Sethostname([]byte("inside-container"))
   syscall.Chroot("/root/containerFS")
   syscall.Chdir("/") // set the working directory inside container
   syscall.Mount("proc", "proc", "proc", 0, "")    
   cmd := exec.Command(os.Args[2], os.Args[3:]...)
   cmd.Stdin = os.Stdin
   cmd.Stdout = os.Stdout
   cmd.Stderr = os.Stderr
   
   cmd.Run()
   
   syscall.Unmount("/proc", 0)
}
func cg() {
   cgroups := "/sys/fs/cgroup/"
   pids := filepath.Join(cgroups, "pids")
   os.Mkdir(filepath.Join(pids, "ourContainer"), 0755)
   ioutil.WriteFile(filepath.Join(pids, "ourContainer/pids.max"), []byte("10"), 0700)
   //up here we limit the number of child processes to 10
   
   ioutil.WriteFile(filepath.Join(pids, "ourContainer/notify_on_release"), []byte("1"), 0700)
   
   ioutil.WriteFile(filepath.Join(pids, "ourContainer/cgroup.procs"), []byte(strconv.Itoa(os.Getpid())), 0700)
   // up here we write container PIDs to cgroup.procs
}