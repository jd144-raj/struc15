package P6;

import java.util.Scanner;

public class BellmanFord {

    private int distances[];
    private int numberOfVertices;
    public static final int MAX_VALUE = 999;

    public BellmanFord(int numberOfVertices) {
        this.numberOfVertices = numberOfVertices;
        distances = new int[numberOfVertices + 1];
    }

    public void bellmanFordEvaluation(int source, int adjacencyMatrix[][]) {
        for (int node = 1; node <= numberOfVertices; node++) {
            distances[node] = MAX_VALUE;
        }

        distances[source] = 0;

        for (int node = 1; node <= numberOfVertices - 1; node++) {
            for (int sourceNode = 1; sourceNode <= numberOfVertices; sourceNode++) {
                for (int destinationNode = 1; destinationNode <= numberOfVertices; destinationNode++) {
                    if (adjacencyMatrix[sourceNode][destinationNode] != MAX_VALUE) {
                        if (distances[destinationNode] > distances[sourceNode] + adjacencyMatrix[sourceNode][destinationNode]) {
                            distances[destinationNode] = distances[sourceNode] + adjacencyMatrix[sourceNode][destinationNode];
                        }
                    }
                }
            }
        }

        for (int sourceNode = 1; sourceNode <= numberOfVertices; sourceNode++) {
            for (int destinationNode = 1; destinationNode <= numberOfVertices; destinationNode++) {
                if (adjacencyMatrix[sourceNode][destinationNode] != MAX_VALUE) {
                    if (distances[destinationNode] > distances[sourceNode] + adjacencyMatrix[sourceNode][destinationNode]) {
                        System.out.println("The Graph contains a negative edge cycle");
                        return;
                    }
                }
            }
        }

        for (int vertex = 1; vertex <= numberOfVertices; vertex++) {
            System.out.println("Distance from source " + source + " to " + vertex + " is " + distances[vertex]);
        }
    }

    public static void main(String[] args) {
        int numberOfVertices = 0;
        int source;
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the number of vertices: ");
        numberOfVertices = scanner.nextInt();

        int adjacencyMatrix[][] = new int[numberOfVertices + 1][numberOfVertices + 1];

        System.out.println("Enter the adjacency matrix: ");
        for (int i = 1; i <= numberOfVertices; i++) {
            for (int j = 1; j <= numberOfVertices; j++) {
                adjacencyMatrix[i][j] = scanner.nextInt();
                if (i == j) {
                    adjacencyMatrix[i][j] = 0;
                    continue;
                }
                if (adjacencyMatrix[i][j] == 0) {
                    adjacencyMatrix[i][j] = MAX_VALUE;
                }
            }
        }

        System.out.print("Enter the source vertex: ");
        source = scanner.nextInt();

        BellmanFord bellmanFord = new BellmanFord(numberOfVertices);
        bellmanFord.bellmanFordEvaluation(source, adjacencyMatrix);

        scanner.close();
    }
}
