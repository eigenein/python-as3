package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class BundlePopupSkillClip extends GuiClipNestedContainer
   {
       
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public function BundlePopupSkillClip()
      {
         image_frame = new GuiClipImage();
         image_item = new GuiClipImage();
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function setData(param1:BundleSkillValueObject) : void
      {
         image_frame.image.texture = AssetStorage.rsx.popup_theme.getTexture(param1.skill.frameAssetTexture);
         image_item.image.texture = AssetStorage.skillIcon.getItemTexture(param1.skill);
         var _loc2_:TooltipVO = new TooltipVO(TooltipTextView,param1.name + "\n" + param1.desc);
         TooltipHelper.addTooltip(graphics,_loc2_);
      }
   }
}
