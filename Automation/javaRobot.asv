 screens = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment().getScreenDevices();
 mouse = java.awt.Robot(screens(1));
% void mouseMove(int x, int y)
% void mousePress(int buttons)
% void mouseRelease(int buttons)
% java.awt.event.InputEvent.BUTTON1_MASK   // left mouse button 
% java.awt.event.InputEvent.BUTTON2_MASK   // middle mouse button
% java.awt.event.InputEvent.BUTTON3_MASK   // right mouse button
% robot.keyPress    (java.awt.event.KeyEvent.VK_V);
% robot.keyRelease  (java.awt.event.KeyEvent.VK_V);
% robot.keyPress    (java.awt.event.KeyEvent.VK_E);
% robot.keyRelease  (java.awt.event.KeyEvent.VK_E);
% robot.keyPress    (java.awt.event.KeyEvent.VK_R);
% robot.keyRelease  (java.awt.event.KeyEvent.VK_R);
% robot.keyPress    (java.awt.event.KeyEvent.VK_ENTER);
% robot.keyRelease  (java.awt.event.KeyEvent.VK_ENTER);



robot = java.awt.Robot;
%set(0,'PointerLocation',[x y]);
% screens = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment().getScreenDevices();
% scrSize = get(0,'ScreenSize');
% x=scrSize(3);
% y=scrSize(4);
% robot.mouseMove(x,scrSize(2)-y);
% mouse.mouseMove(0, 0);

%all docs pointerlocation is [2207,953]
y=1080-953;
robot.mouseMove(2207,y)
%waitForIdle()
for i = 1:2
    robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
    robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
    pause(0.05); % extra pause to let all mouse actions to complete
end
    %robot.waitForIdle(); % blocks until last action is dequeued (not actually performed)
    
screens = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment().getScreenDevices();
scrSize = get(0,'ScreenSize');    
yOffset = scrSize(4);
tTotal = 10; %seconds
tTime = 0.1; %seconds per update
tNumber = tTotal/tTime;
tStart = now*100000;
tCurrent = now*100000;
tIndex = 0;
%track mouse    
coordMouse = single(zeros([tNumber,2]));

while(tIndex < tNumber)
        tIndex = tIndex+1;
        crdMouse = get(0, 'PointerLocation');
        xMouse = single(crdMouse(1));
        yMouse = single(yOffset-crdMouse(2));
        coordMouse(tIndex,:) = [xMouse yMouse];
        display(coordMouse)
        pause(tTime);
end 
tIndex = 0;
while(tIndex < tNumber)
    tIndex = tIndex+1;
    xMouse = coordMouse(tIndex,1);
    xMouse = coordMouse(tIndex,2);
    set(0,'PointerLocation',coordMouse(tIndex,:));
    pause(tTime);
end