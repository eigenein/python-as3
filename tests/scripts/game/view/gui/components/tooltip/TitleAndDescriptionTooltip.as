package game.view.gui.components.tooltip
{
   import feathers.controls.LayoutGroup;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.ITooltipView;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import starling.display.DisplayObjectContainer;
   
   public class TitleAndDescriptionTooltip extends LayoutGroup implements ITooltipView
   {
       
      
      private var clip:TitleAndDescriptionTooltipClip;
      
      public function TitleAndDescriptionTooltip()
      {
         super();
      }
      
      public function hide() : void
      {
         if(parent && this)
         {
            parent.removeChild(this);
         }
      }
      
      public function placeHint(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Function = !!param1.tooltipVO?param1.tooltipVO.placeFn:null;
         if(_loc3_ != null)
         {
            _loc3_.apply(this,[param1,param2]);
         }
         else
         {
            placeSelf(param1,param2);
         }
      }
      
      public function placeSelf(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Point = TooltipLayerMediator.calcPosition(this,param2);
         x = _loc3_.x;
         y = _loc3_.y;
      }
      
      public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc3_ = param1.tooltipVO.hintData as TitleAndDescriptionValueObject;
            if(_loc3_)
            {
               clip.tf_title.text = _loc3_.title;
               clip.tf_desc.text = _loc3_.description;
            }
            clip.tooltip_layout.validate();
            clip.bg.graphics.height = clip.tooltip_layout.graphics.y + clip.tooltip_layout.graphics.height + 16;
            width = clip.graphics.width;
            height = clip.graphics.height;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TitleAndDescriptionTooltipClip,"tooltip_title_and_description");
         addChild(clip.graphics);
      }
   }
}
