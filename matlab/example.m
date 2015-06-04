%{
    Copyright (c) 2015, Philipp Krähenbühl
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
        * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
        * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
        * Neither the name of the Stanford University nor the
        names of its contributors may be used to endorse or promote products
        derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY Philipp Krähenbühl ''AS IS'' AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL Philipp Krähenbühl BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%}
clear all;
init_lpo;

% Set a boundary detector by calling (before creating an OverSegmentation!):
lpo_mex( 'setDetector', 'MultiScaleStructuredForest("../data/sf.dat")' );

% Setup the proposal pipeline (baseline)
p = Proposal( 'model', '../models/lpo_VOC_0.1.dat' );

% Load in image
images = {'pears.png','peppers.png'};

for it = 1:2
    I = imread(images{it});

    % Create an over-segmentation
    tic();
    os = OverSegmentation( I );
    t1 = toc();

    % Generate proposals
    tic();
    props = p.propose( os );
    t2 = toc();

    fprintf( ' %d proposals generated. OverSeg %0.3fs, Proposals %0.3fs. Image size %d x %d.\n', size(props,1), t1, t2, size(I,1), size(I,2) );

    % If you just want boxes
    boxes = os.maskToBox( props );
    figure()
    for i=1:9
        mask = props(i,:);
        m = uint8(mask( os.s()+1 ));
        % Visualize the mask
        subplot(3,3,i)
        II = 1*I;
        II(:,:,1) = II(:,:,1) .* (1-m) + m*255;
        II(:,:,2) = II(:,:,2) .* (1-m);
        II(:,:,3) = II(:,:,3) .* (1-m);
        imagesc( II );
        rectangle( 'Position', [boxes(i,1),boxes(i,2),boxes(i,3)-boxes(i,1)+1,boxes(i,4)-boxes(i,2)+1], 'LineWidth',2, 'EdgeColor',[0,1,0] );
    end
end
