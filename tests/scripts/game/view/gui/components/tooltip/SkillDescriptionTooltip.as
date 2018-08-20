package game.view.gui.components.tooltip
{
   import feathers.controls.Label;
   import feathers.layout.VerticalLayout;
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.view.gui.components.GameLabel;
   import starling.display.DisplayObjectContainer;
   
   public class SkillDescriptionTooltip extends TooltipTextView
   {
       
      
      private var _titleLabel:Label;
      
      private var data:SkillDescription;
      
      public function SkillDescriptionTooltip()
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
         _titleLabel = GameLabel.special16();
         addChild(_titleLabel);
         _label = GameLabel.special16();
         _label.y = 20;
         addChild(_label);
         _label.wordWrap = true;
         var _loc1_:int = 400;
         _label.maxWidth = _loc1_;
         _titleLabel.maxWidth = _loc1_;
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         layout = _loc1_;
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "left";
         _loc1_.padding = 20;
      }
      
      protected function commitData(param1:*) : void
      {
         var _loc2_:SkillDescription = param1 as SkillDescription;
         if(this.data == _loc2_)
         {
            return;
         }
         this.data = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         onDataUpdate();
      }
      
      private function onDataUpdate() : void
      {
         var _loc1_:SkillTooltipMessageFactory = new SkillTooltipMessageFactory(null,data);
         _titleLabel.text = _loc1_.title(data.name);
         _label.text = _loc1_.description(DataStorage.level.getMaxTeamLevel());
      }
   }
}
