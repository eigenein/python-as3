package game.view.popup.herodescription
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.SkillDescriptionTooltip;
   import starling.display.DisplayObject;
   import starling.display.Image;
   
   public class HeroDescriptionSkillRenderer extends ListItemRenderer
   {
       
      
      protected var tooltipVO:TooltipVO;
      
      private var frame:Image;
      
      private var icon:Image;
      
      public function HeroDescriptionSkillRenderer()
      {
         tooltipVO = new TooltipVO(SkillDescriptionTooltip,null);
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         if(data != param1)
         {
            .super.data = param1;
            invalidate("data");
         }
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         TooltipHelper.removeTooltip(this);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         TooltipHelper.addTooltip(this,tooltipVO);
      }
      
      override protected function draw() : void
      {
         var _loc1_:* = null;
         if(isInvalid("data") && data)
         {
            removeChildren(0,-1,true);
            _loc1_ = data as SkillDescription;
            if(_loc1_)
            {
               icon = new Image(AssetStorage.skillIcon.getItemTexture(_loc1_));
               addChild(icon);
               frame = new Image(AssetStorage.rsx.popup_theme.getTexture(_loc1_.frameAssetTexture));
               addChild(frame);
               icon.x = 6;
               icon.y = 6;
               icon.width = frame.width - icon.x * 2;
               icon.height = frame.height - icon.y * 2;
               tooltipVO.hintData = _loc1_;
            }
         }
         super.draw();
      }
   }
}
