package P4;

import java.util.*;

public class TSP {
    
    private static final int INF = Integer.MAX_VALUE;
    private static int[][] distanceMatrix;
    private static int[][] dp;
    private static int n;
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Input the number of cities
        System.out.print("Enter the number of cities: ");
        n = scanner.nextInt();
        
        // Initialize the distance matrix
        distanceMatrix = new int[n][n];
        
        // Input the distance matrix
        System.out.println("Enter the distance matrix:");
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                distanceMatrix[i][j] = scanner.nextInt();
            }
        }
        
        // Initialize dp array
        dp = new int[n][(1 << n)];
        for (int[] row : dp) {
            Arrays.fill(row, -1);
        }
        
        // Starting from city 0 with only the first city visited
        int result = tsp(0, 1);
        
        // Output the minimum path cost
        System.out.println("Minimum Path Cost: " + result);
        
        // Retrieve and output the best path
        System.out.print("Best Path: ");
        printPath();
    }
    
    // Recursive function to find the minimum cost path using DP
    private static int tsp(int city, int mask) {
        if (mask == (1 << n) - 1) { // All cities have been visited
            return distanceMatrix[city][0]; // Return to the starting city
        }
        
        if (dp[city][mask] != -1) {
            return dp[city][mask];
        }
        
        int minCost = INF;
        
        for (int nextCity = 0; nextCity < n; nextCity++) {
            if ((mask & (1 << nextCity)) == 0) { // If the next city hasn't been visited yet
                int newCost = distanceMatrix[city][nextCity] + tsp(nextCity, mask | (1 << nextCity));
                minCost = Math.min(minCost, newCost);
            }
        }
        
        return dp[city][mask] = minCost;
    }
    
    // Function to print the best path found by the DP algorithm
    private static void printPath() {
        int mask = 1;
        int city = 0;
        
        System.out.print((city + 1) + " ");
        
        for (int i = 1; i < n; i++) {
            int nextCity = -1;
            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) == 0) {
                    int newCost = distanceMatrix[city][j] + dp[j][mask | (1 << j)];
                    if (newCost == dp[city][mask]) {
                        nextCity = j;
                        break;
                    }
                }
            }
            city = nextCity;
            mask |= (1 << city);
            System.out.print((city + 1) + " ");
        }
        
        System.out.println("(Returning to the starting city)");
    }
}
