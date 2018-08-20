package game.view.gui.components
{
   import engine.core.clipgui.GuiClipScale9Image;
   
   public class ClipButtonLabeledResizeable extends ClipButtonLabeled
   {
       
      
      public const upSkin:GuiClipScale9Image = new GuiClipScale9Image();
      
      public function ClipButtonLabeledResizeable()
      {
         super();
      }
      
      public function expandToFitTextWidth() : void
      {
         var _loc1_:Number = NaN;
         if(guiClipLabel.textWidth > guiClipLabel.width)
         {
            _loc1_ = guiClipLabel.textWidth - guiClipLabel.width;
            guiClipLabel.width = guiClipLabel.width + _loc1_;
            upSkin.graphics.width = upSkin.graphics.width + _loc1_;
            graphics.dispatchEventWith("layoutDataChange");
         }
      }
   }
}
