function [normalized_vector] = normalVec(dir)
V = giveVector(dir);
dist = pdist([V(40);V(43)],'euclidean');
fixedDist = 50;
scale = fixedDist / dist;
V = scale .* V;
normalized_vector = V;