class PriorityQueue {
    constructor(){
        this.values = [];
    }
    enqueue(val, priority) {
        this.values.push({val, priority});
        this.sort();
    }
    dequeue() {
        return this.values.shift();
    }
    sort(){
        this.values.sort((a,b) => a.priority-b.priority);
    }
}

class WeightedGraph {
    constructor(){
        this.adjacencyList = {};
    }
    addVertex(vertex){
        if(!this.adjacencyList[vertex]) this.adjacencyList[vertex] = [];
    }
    addEdge(vertex1,vertex2,weight){
        // neighbour goes both ways!
        this.adjacencyList[vertex1].push({node:vertex2, weight});
        this.adjacencyList[vertex2].push({node:vertex1, weight});
    }
    Dijkstra(start, finish){
        // to hold summed distances from start node to current node
        const nodes = new PriorityQueue();
        const distances = {};

        // to hold shortest previous vertex node
        const previous = {};
        let smallest;

        // to return at the end
        let path = [];

        //build up initial state (for all vertices)
        for(let vertex in this.adjacencyList){
            if(vertex === start){
                distances[vertex] = 0;
                nodes.enqueue(vertex, 0);
            } else {
                distances[vertex] = Infinity;
                nodes.enqueue(vertex, Infinity);
            }
            previous[vertex] = null;
        }

        //as long as there's node in the queue
        //to be processed with shortest distance first
        while(nodes.values.length){
            smallest = nodes.dequeue().val;
            if(smallest === finish){
                //DONE
                console.log(distances);
                console.log(previous);
                while(previous[smallest]){
                    path.unshift(smallest);
                    smallest = previous[smallest];
                }
                break;
            }
            if(smallest||distance[smallest]!==Infinity){
                for(let neighbor in this.adjacencyList[smallest]){
                    //find neighboring node
                    let nextNode = this.adjacencyList[smallest][neighbor];
                    let candidateDist = distances[smallest] + nextNode.weight;
                    let nextN = nextNode.node;
                    // only update if candidate distance is lesser than
                    // existing distance to next neighbor
                    if(candidateDist<distances[nextN]){
                        distances[nextN] = candidateDist;
                        //update previous's node for this neighbor
                        previous[nextN] = smallest;
                        // update summed distance to next neighbor
                        nodes.enqueue(nextN, candidateDist)
                    }
                }
            }
        }
        path.unshift(start)
        console.log(path)
    }
}

let g = new WeightedGraph()
g.addVertex("A");
g.addVertex("B");
g.addVertex("C");
g.addVertex("D");
g.addVertex("E");
g.addVertex("F");

g.addEdge("A","B",4);
g.addEdge("A","C",2);
g.addEdge("B","E",3);
g.addEdge("C","D",2);
g.addEdge("C","F",4);
g.addEdge("D","E",3);
g.addEdge("D","F",1);
g.addEdge("E","F",1);

g.Dijkstra("A", "F");
g.Dijkstra("A", "E");









