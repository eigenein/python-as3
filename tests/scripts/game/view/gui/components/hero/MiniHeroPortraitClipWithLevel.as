package game.view.gui.components.hero
{
   import engine.core.clipgui.GuiClipImage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.ClipLabel;
   
   public class MiniHeroPortraitClipWithLevel extends MiniHeroPortraitClip
   {
       
      
      public var image_level:GuiClipImage;
      
      public var tf_level:ClipLabel;
      
      public function MiniHeroPortraitClipWithLevel()
      {
         tf_level = new ClipLabel();
         super();
      }
      
      override public function set data(param1:UnitEntryValueObject) : void
      {
         .super.data = param1;
         if(param1)
         {
            tf_level.text = String(param1.level);
            image_level.image.texture = param1.levelBackgroundAssetTexture;
         }
      }
   }
}
