%%-------------------------------------------------------------------------
function elementInd = select_element_to_remove(population, nPop ,nObj, ...
    nVar, nPV, ranks, nPFevalHV, refPoint)
if nPV > nPFevalHV
    elementsInd = find(ranks==nPV);
    frontsize = size(elementsInd,1);
    % remove random element
    elementInd = ceil(rand(1)*frontsize);
    if elementInd == 0
        elementInd=1;
    end
else
    % use HV
    elementsInd = find(ranks==nPV);
    frontsize = size(elementsInd,1);
    if frontsize==1
        elementInd = 1;
    else
        frontObjectives = population(elementsInd,nVar+1:nVar+nObj);
        if refPoint==0
            refPoint = max(frontObjectives)+1;
        else
            index = false(frontsize,1);
            for i = 1:frontsize
                if sum(frontObjectives(i,:) >= refPoint) > 0
                    index(i) = true;
                end;
            end;
            if sum(index) > 0
                [maxVal, IX] = max(max(frontObjectives-...
                    repmat(refPoint,frontsize,1), [], 2));
                elementInd = elementsInd(IX(1));
                return;
            end;
        end
        if nObj == 2
            [frontObjectives IX] = sortrows(frontObjectives, 1);
            deltaHV(IX(1)) = ...
                (frontObjectives(2,1) - frontObjectives(1,1)) .* ...
                (refPoint(2) - frontObjectives(1,2));
            for i = 2:frontsize-1
                deltaHV(IX(i)) = ...
                    (frontObjectives(i+1,1) - frontObjectives(i,1))...
                    .* ...
                    (frontObjectives(i-1,2) - frontObjectives(i,2));
            end;
            deltaHV(IX(frontsize)) = ...
                (refPoint(1) - frontObjectives(frontsize,1)) .* ...
                (frontObjectives(frontsize-1,2) - ...
                frontObjectives(frontsize,2));
        else
            currentHV = hv(frontObjectives', refPoint);
            deltaHV = zeros(1,frontsize);
            for i=1:frontsize
                myObjectives = frontObjectives;
                myObjectives(i,:)=[];
                myHV = hv(myObjectives', refPoint);
                deltaHV(i) = currentHV - myHV;
            end
        end
        [deltaHV,IX]=min(deltaHV);
        elementInd = IX(1);
    end
end
elementInd = elementsInd(elementInd);
end

%%


