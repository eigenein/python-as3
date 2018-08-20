package game.mediator.gui.popup.titan
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.SkillTooltip;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class TitanSkillRenderer extends ListItemRenderer
   {
       
      
      private var frame:Image;
      
      private var icon:Image;
      
      private var tooltipVO:TooltipVO;
      
      public function TitanSkillRenderer()
      {
         tooltipVO = new TooltipVO(SkillTooltip,null);
         super();
      }
      
      override public function dispose() : void
      {
         TooltipHelper.removeTooltip(this);
         super.dispose();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:TitanSkillValueObject = data as TitanSkillValueObject;
         if(_loc1_)
         {
            tooltipVO.hintData = _loc1_.tooltipVo;
            updateImage(_loc1_.skill);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         TooltipHelper.addTooltip(this,tooltipVO);
      }
      
      protected function updateImage(param1:SkillDescription) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Texture = AssetStorage.skillIcon.getItemTexture(param1);
         var _loc3_:Texture = AssetStorage.rsx.popup_theme.getTexture(param1.frameAssetTexture);
         if(icon)
         {
            icon.texture = _loc2_;
            icon.readjustSize();
         }
         else
         {
            icon = new Image(_loc2_);
            addChild(icon);
         }
         if(frame)
         {
            frame.texture = _loc3_;
            frame.readjustSize();
         }
         else
         {
            frame = new Image(_loc3_);
            addChild(frame);
         }
         icon.x = 6;
         icon.y = 6;
         icon.width = frame.width - icon.x * 2;
         icon.height = frame.height - icon.y * 2;
      }
   }
}
