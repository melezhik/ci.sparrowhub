module=$(config module)

rm -rf log.txt

if zef install $m 1>log.txt 2>&1; then
  echo "module $m installation succeed"
  update_state success 1
 else
  echo "module $m installation failed"
  update_state success 0
fi
