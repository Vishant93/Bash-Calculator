#!/usr/bin/env 

echo "Welcome to the basic calculator!" | tee operation_history.txt
numsRegex='^[-+]?[0-9]+\.?[0-9]*$'
opsRegex='[\^\+\/\*\-]'
num1=""
op=""
num2=""
while [[ $num1 != "quit" ]] || [[ $op != "quit" ]] || [[ $num2 != "quit" ]];
do
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt
    read -r num1 op num2
    echo "$num1 $op $num2" >> operation_history.txt
    if [[ "$num1" =~ $numsRegex &&  -n "$num1" ]] && [[ "$op" =~ $opsRegex &&  -n "$op" && ${#op} -eq 1 ]] && [[ "$num2" =~ $numsRegex && -n "$num2" ]]; then
        case $op in 
    
          ^)
            arithmetic_result=$(echo "scale=2; $num1^$num2" | bc -l)
            printf "%s\n" "$arithmetic_result" | tee -a operation_history.txt
            ;;
          +)
            arithmetic_result=$(echo "scale=2; $num1+$num2" | bc -l)
            printf "%s\n" "$arithmetic_result" | tee -a operation_history.txt
            ;;
          -)
            arithmetic_result=$(echo "scale=2; $num1 - $num2" | bc -l)
            printf "%s\n" "$arithmetic_result" | tee -a operation_history.txt
            ;;
          /)
            arithmetic_result=$(echo "scale=2; $num1/$num2" | bc -l)
            printf "%s\n" "$arithmetic_result" | tee -a operation_history.txt
            ;;
          *)
            arithmetic_result=$(echo "scale=2; $num1*$num2" | bc -l)
            printf "%s\n" "$arithmetic_result" | tee -a operation_history.txt
            ;;
    
    esac
    elif [[ $num1 == "quit" ]] || [[ $op == "quit" ]] || [[ $num2 == "quit" ]]; then
        echo "Goodbye!" | tee -a operation_history.txt
        break
    else
        echo "Operation check failed!" | tee -a operation_history.txt
    fi
done

# add your solution