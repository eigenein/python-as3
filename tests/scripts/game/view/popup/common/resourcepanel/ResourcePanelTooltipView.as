package game.view.popup.common.resourcepanel
{
   import feathers.controls.LayoutGroup;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelTooltipData;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.ITooltipView;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import starling.display.DisplayObjectContainer;
   
   public class ResourcePanelTooltipView extends LayoutGroup implements ITooltipView
   {
       
      
      private var clip:PopupResourcePanelTooltipViewClip;
      
      private var _hintData:ResourcePanelTooltipData;
      
      public function ResourcePanelTooltipView()
      {
         super();
      }
      
      public function get hintData() : ResourcePanelTooltipData
      {
         return _hintData;
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
         param2.addChild(this);
         var _loc3_:ResourcePanelTooltipData = param1.tooltipVO.hintData as ResourcePanelTooltipData;
         clip.tf_text.text = _loc3_.text;
         clip.tf_text.validate();
         clip.bg.graphics.width = clip.tf_text.width + 28;
         clip.bg.graphics.height = clip.tf_text.height + 30;
         draw();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         create();
      }
      
      protected function create() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(PopupResourcePanelTooltipViewClip,"resource_panel_tooltip");
         addChild(clip.graphics);
      }
   }
}
