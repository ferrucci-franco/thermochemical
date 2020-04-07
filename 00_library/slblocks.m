function blkStruct = slblocks
    % This function specifies that the library should appear
    % in the Library Browser and be cached in the browser repository.

    Browser.Library = 'thermochemical';     % is the name of the library

    Browser.Name = '@ Thermochemical';   % the library name that appears 
                                         % in the Library Browser
    blkStruct.Browser = Browser; 