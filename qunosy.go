package main

import (
    "os"
    "github.com/codegangsta/cli" // cli.goをインポート
    "os/exec"
    "path/filepath"
    "fmt"
)

func main() {
    app := cli.NewApp()
    app.Name = "qunosy"            // ヘルプを表示する際に使用される
    app.Usage = "print arguments" // ヘルプを表示する際に使用される
    app.Version = "0.1.0"         // ヘルプを表示する際に使用される
    absPath, _ := filepath.Abs("../qunosy")
    app.Action = func(c *cli.Context) { // コマンド実行時の処理
        if len(c.Args()) > 1 {
            if c.Args()[0] == "reload" {
                reload := exec.Command("sh", absPath + "/reload.sh", c.Args()[1])
                reloadOut, err := reload.Output()
                fmt.Println("Reloading qiita log ...")
                if err != nil {
                    fmt.Println(err.Error())
                    return
                }
                fmt.Print(string(reloadOut))
            } else {
                return
            }
        } else {
            qunosy := exec.Command("sh", absPath + "/qunosy.sh")
            qunosyOut, err := qunosy.Output()
            if err != nil {
                fmt.Println(err.Error())
                return
            }
            fmt.Print(string(qunosyOut))
        }
    }
    app.Run(os.Args)
}