package P8;

import java.util.*;

public class FordF {
    private int V;
    private int[][] capacity;

    public FordF(int V) {
        this.V = V;
        capacity = new int[V][V];
    }

    public void addEdge(int u, int v, int cap) {
        capacity[u][v] = cap;
    }

    private boolean bfs(int[][] residual, int s, int t, int[] parent) {
        boolean[] visited = new boolean[V];
        Queue<Integer> queue = new LinkedList<>();
        queue.add(s);
        visited[s] = true;
        parent[s] = -1;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v = 0; v < V; v++) {
                if (!visited[v] && residual[u][v] > 0) {
                    queue.add(v);
                    parent[v] = u;
                    visited[v] = true;
                    if (v == t) return true;
                }
            }
        }
        return false;
    }

    public int fordFulkerson(int s, int t) {
        int[][] residual = new int[V][V];
        for (int i = 0; i < V; i++) System.arraycopy(capacity[i], 0, residual[i], 0, V);
        int maxFlow = 0, pathFlow;
        int[] parent = new int[V];

        while (bfs(residual, s, t, parent)) {
            pathFlow = Integer.MAX_VALUE;
            for (int v = t; v != s; v = parent[v]) {
                int u = parent[v];
                pathFlow = Math.min(pathFlow, residual[u][v]);
            }

            for (int v = t; v != s; v = parent[v]) {
                int u = parent[v];
                residual[u][v] -= pathFlow;
                residual[v][u] += pathFlow;
            }

            maxFlow += pathFlow;
        }

        return maxFlow;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of vertices: ");
        int V = sc.nextInt();
        FordF graph = new FordF(V);

        System.out.print("Enter number of edges: ");
        int E = sc.nextInt();

        System.out.println("Enter edges with capacities (source destination capacity):");
        for (int i = 0; i < E; i++) {
            int u = sc.nextInt();
            int v = sc.nextInt();
            int cap = sc.nextInt();
            graph.addEdge(u, v, cap);
        }

        System.out.print("Enter source vertex: ");
        int s = sc.nextInt();
        System.out.print("Enter sink vertex: ");
        int t = sc.nextInt();

        System.out.println("The maximum possible flow is " + graph.fordFulkerson(s, t));
        sc.close();
    }
}
