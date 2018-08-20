package game.view.popup.hero.upgrade
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.skills.SkillDescription;
   
   public class SkillIconClip extends GuiClipNestedContainer
   {
       
      
      public var frame_image:GuiClipImage;
      
      public var icon_image:GuiClipImage;
      
      public function SkillIconClip()
      {
         frame_image = new GuiClipImage();
         icon_image = new GuiClipImage();
         super();
      }
      
      public function set data(param1:SkillDescription) : void
      {
         frame_image.image.texture = AssetStorage.rsx.popup_theme.getTexture(param1.frameAssetTexture);
         icon_image.image.texture = AssetStorage.skillIcon.getItemTexture(param1);
      }
   }
}
