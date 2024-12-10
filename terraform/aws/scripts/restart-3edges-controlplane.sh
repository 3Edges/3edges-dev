#!/bin/bash

# Restart the Deployment in the "3edges" namespace where the label "type=3edges_control_plane" matches.
kubectl rollout restart deployment --selector="type=3edges_control_plane" -n 3edges

echo -ne "\n"

# Function to display the message and progress bar
progress_bar_with_message() {
  local progress=$1
  local total=50  # Total width of the progress bar
  local completed=$((progress * total / 100))
  local remaining=$((total - completed))

  # Print the message with the progress bar on the same line
  printf "\rRestarting the 3Edges control plane. PLEASE WAIT [%-${total}s] %d%%" "$(printf '#%.0s' $(seq 1 $completed))" "$progress"
}

# Main script
# Simulate a task with progress updates
for i in {1..100}; do
  progress_bar_with_message $i  # Update the progress bar
  sleep 0.1                     # Simulate work
done

# Move to the next line after the progress bar completes
echo -e "\n"

# Get the list of Pods in the "3edges" namespace with the label "type=3edges_control_plane".
kubectl get pods --selector="type=3edges_control_plane" -n 3edges