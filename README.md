# Social Network Theory  
## Basic Terminology  
<b> Actor</b> (i.e., node, vertex): an individual or group of individuals we are choosing to study.  

<b>Tie</b> (i.e., relation, edge): a relationship between two actors.  
&#8226; undirected ties: the relationship means the same thing to both actors (e.g., went to the same school)  
&#8226; directed ties: the relationship is either one directional or bi-directional (e.g., looks up to)  

<b>Network</b> (i.e., Graph): a collection of actors and the ties between them.  

<b>Multiplex networks</b>: networks where more than one kind of tie is present (e.g., relationships between managers, who have a network containing multiple tie types between actors like advice seeking, being friends, working for someone, etc.)  

<b>Weighted ties</b>: relationships of varying strength  

<b>Group</b>: a subset of the actors which share some characteristic in common (e.g., one group made up of all actors that work in HR department). For example, we might want to test a hypothesis about the number of friendship ties between workers at a company who are part of different departments vs. those in the same departments.  

<b>Geodesic distance</b>: the least number of connections (ties) that must be traversed to get between any two nodes.  

## Types of Social Network Data  
<b>Sociomatrix</b> (i.e., adjacency matrix): a way of representing directed or undirected ties between actors using a numerical matrix.  
&#8226; one column for each actor and one row for each actor. (i.e., [row i, column j])  
&#8226; the diagonal elements of this matrix (e.g., second row, second column) are always equal, signaling that actors do not tie to themselves.  
&#8226; very ready for many statistical analyses, but can take up a lot of space and be difficult to enter data into by hand.  

<b> Edgelist</b>: only captures information about existing ties so it needs to be supplemented with knowledge of the total number of actors in the network.  
&#8226; efficient data storage and easy to enter, but needs to use a common naming system and keep track of any nodes that do not have any ties to them.

## Properties of Nodes  
<b>Degree Centrality</b>: basic network measure that captures the number of ties to a given actor.  
&#8226; Undirected networks: a count of the number of ties for every actor  
&#8226; Directed networks: actors can have both indegree and outdegree centrality scores  
&#8226; signals importance or power (e.g., increased access to information)  

<b>Betweenness Centrality</b>: the number of shortest paths between actors that go through a particular actor.  
&#8226; measures the degree to which information have to flow through a particularly actor and their relative importance as an intermediary in the network.  

<b>Closeness centrality</b>: measures how many steps (ties) are required for a particular actor to access every other actor in the network.  
&#8226; 1 / sum of geodesic distances from an actor to all actors in the network  
&#8226; the measure will reach its maximum for a given network size when an actor is directly connected to all others in the network and its minimum when an actor is not connected to any others.  
&#8226; short path lengths between actors signal that they are closer to each other.  

<b>Eigenvector centrality</b>: measures the degree to which an actor is connected to other well connected actors  

<b>Brokerage</b>: describes the position of actors such that they occupy an advantageous position where they can broker interactions between other actors in the network. <b>Brokerage centrality</b> is a measure of the degree to which an actor occupies a brokerage position across all pairs of actors. It is meant to capture the intuition that a broker serves as a go-between and thus can gain benefits from their position as an intermediary.  
(a) <b>Coordinator</b>: an actor in the same group who connects the two nodes. An example might be a graduate student who makes sure that all of the rest of their cohort is made aware of parties being hosted by anyone in their cohort.  
(b) <b>Itinerant</b>: a member of an outside group that connects two others who share group membership.  
(c) <b>Gatekeeper</b>:  a member of the same group as the target; a member of another group hopes to connect with that can control whether or not that outside actor is able to gain access to the in group member. An example might be a secretary or office manager.  
(d) <b>Representative</b>: an actor that wishes to connect with an actor outside of the group but has to go through an intermediary. An example is an Ambassador for a country.  
(e) <b>Liason</b>:  a member of a group that is distance from two actors that wish to connect but do not share group membership themselves. A delivery truck driver is a good example.  

## Network Relationships and Structures  
<b>Reciprocity</b>: the tendency for directed ties from actor i to actor j be be reciprocated and sent back from actor j to actor i. This captures the classic finding that feeling and actions tend to be reciprocated.  

<b>Transitivity</b>: the tendency for friends of friends to be friends and enemies of enemies to be enemies. More generally a transitive relationship is one where two nodes being connected to a third increases the likelihood that they will connect themselves.  

<b>Preferential Attachment</b> (Popularity):  the tendency for nodes that are already central to gain more connections at a greater rate than those who are not already central. This is often the case in academia where as a researcher becomes more active and collaborates more in publishing, they are more likely to attract new collaborators who want to work with them.  

<b> structural equivalence</b>: actors occupying the same position in the network relative to all other actors.  

<b>Clique</b>: a subset of actors in a network such that every two actors in the subset are connected by a tie. This definition follows the common english language usage of the word meaning a densely connected group.  

<b>Star</b>: a network structure where all ties connect to one central node, making the shape of a star.  

## Network Properties  
All the properties discussed above refer to individual actors or subsets of actors in a network. Network properties are important because they tell you about how actors in the network behavior and function as a whole.  

<b>Network Density</b>: the number of edges divided by the total number of possible edges (possible edges mean the maximum number of edges physically and mathematically allwed to the given number of vertices)  

<b>Centralization</b> (degree, betweenness, closeness, eigenvector, etc.): a measure of the unevenness of the centrality scores of actors in a network.  
&#8226; ranges from zero, when every actor is just as central, to 1, when one node is maximally central and all others are minimally central.  
&#8226; a good way to express the idea that there are couple of very powerful or important actors in a network or that power/importance is spread out evenly in one simple measure.  

<b>Network Clustering Coefficient</b>: measures the degree to which actors form ties in dense, relatively unconnected (between groups) groups.  

<b>Homophily</b>:  a process where actors who are similar on a particular trait are more likely to form ties. The opposite of homophily is Heterophily, which refers to a process whereby actors who are different from each other are more likely to form ties.  

<b>Modularity</b>: a measure of the degree to which a network displays <b>Community Structure</b>, with clusters that are not densely connected to others but densely connected within cluster.  
&#8226; The Louvain method is one of the variations of modularity optimization techniques  
&#8226; very difficult to calculate, but provides a way to identify community structure on a network where where one is unsure if such a structure exists  

<b>Diameter</b>: the longest of all the calculated shortest paths between actors. Network diameter gives us an idea about how easily reachable actors are on a network.  
&#8226; A very large diameter means that even though there is theoretically a way for ties to connect any two actors through a series of intermediaries, there is no guarantee that they actually will be connected.  
&#8226; Diameter is thus a signal about the ability for information or disease to diffuse on the network.  

There are a number of classic Network Types that can be used to characterize the stereotypical social structure in different situations.  
(a) <b>Regular networks</b>: all actors having the same degree and are often a starting point for simulation studies of networks.  
(b) <b>Small world networks</b>: very efficient for information transfer in that most nodes are not connected (so a high degree of clustering), but also have a relatively short average path length between actors.  
(c) <b>Random networks</b>: robust to disruptions, but may be difficult for people to maintain, especially if ties are across long distances.  
  
Works Cited  
Denny, Matthew. (2014). Social Network Analysis. Matt Denny's Academic Website. http://www.mjdenny.com/workshops/SN_Theory_I.pdf.  
