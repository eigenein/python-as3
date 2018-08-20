package game.view.gui.components.tooltip
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.data.storage.artifact.ArtifactDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.view.gui.components.GameLabel;
   import starling.display.DisplayObjectContainer;
   
   public class ArtifactFragmentTooltip extends TooltipTextView
   {
       
      
      private var artifact:ArtifactDescription;
      
      private var params:GameLabel;
      
      public function ArtifactFragmentTooltip()
      {
         super();
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         param2.addChild(this);
         commitData(param1.tooltipVO.hintData);
         draw();
      }
      
      override protected function createElements() : void
      {
         _label = GameLabel.special16();
         params = GameLabel.special16();
         var _loc1_:* = true;
         params.wordWrap = _loc1_;
         _label.wordWrap = _loc1_;
         _loc1_ = 450;
         params.maxWidth = _loc1_;
         _label.maxWidth = _loc1_;
         addChild(_label);
         addChild(params);
      }
      
      override protected function createLayout() : void
      {
         layout = new VerticalLayout();
         (layout as VerticalLayout).verticalAlign = "middle";
         (layout as VerticalLayout).horizontalAlign = "left";
         (layout as VerticalLayout).padding = 20;
      }
      
      protected function commitData(param1:*) : void
      {
         var _loc2_:ArtifactDescription = param1 as ArtifactDescription;
         if(this.artifact == _loc2_)
         {
            return;
         }
         this.artifact = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         update();
      }
      
      private function update() : void
      {
         _label.text = artifact.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_FRAGMENT");
         addChild(_label);
         addChild(params);
      }
   }
}
