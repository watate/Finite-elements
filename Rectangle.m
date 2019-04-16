%OOP in matlab

%defining a rectangle
classdef Rectangle
    %Rectangle data set class
    properties
    Width
    Height
    Colour
    end
    
    methods
        function Area = getArea(thisRectangle)
            Area = thisRectangle.Width * thisRectangle.Height;
        end
        function Perimeter = getPerimeter(thisRectangle)
            Perimeter = 2*thisRectangle.Width + 2*thisRectangle.Height;
        end
        function thisRectangle = Rectangle(colour, width, height)
            if nargin == 3 %if number of input arguments is 3
                thisRectangle.Colour = colour;
                thisRectangle.Width = width;
                thisRectangle.Height = height;
            end
        end
    end
end


