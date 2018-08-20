package game.view.gui.components.tooltip
{
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.hero.skill.SkillTooltipValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.view.gui.components.GameLabel;
   import starling.display.DisplayObjectContainer;
   
   public class SkillTooltip extends TooltipTextView
   {
       
      
      private var data:SkillTooltipValueObject;
      
      private var _name:GameLabel;
      
      private var _params:GameLabel;
      
      private var _nextLevel:GameLabel;
      
      public function SkillTooltip()
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
         _name = GameLabel.special16();
         _params = GameLabel.special16();
         _nextLevel = GameLabel.special16();
         var _loc1_:* = true;
         _nextLevel.wordWrap = _loc1_;
         _loc1_ = _loc1_;
         _params.wordWrap = _loc1_;
         _label.wordWrap = _loc1_;
         _loc1_ = 450;
         _nextLevel.maxWidth = _loc1_;
         _loc1_ = _loc1_;
         _params.maxWidth = _loc1_;
         _label.maxWidth = _loc1_;
         addChild(_name);
         addChild(_label);
         addChild(_params);
         addChild(_nextLevel);
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
         var _loc2_:SkillTooltipValueObject = param1 as SkillTooltipValueObject;
         if(this.data == _loc2_)
         {
            return;
         }
         if(this.data)
         {
            this.data.signal_update.remove(handler_update);
         }
         this.data = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.signal_update.add(handler_update);
         handler_update();
      }
      
      private function handler_update() : void
      {
         _label.text = data.description;
         if(data.showName)
         {
            _name.text = data.name;
            addChild(_name);
         }
         else if(_name.parent)
         {
            removeChild(_name);
         }
         addChild(_label);
         if(data.showParams)
         {
            _params.text = data.param;
            addChild(_params);
         }
         else if(_params.parent)
         {
            removeChild(_params);
         }
         if(data.showNextLevel)
         {
            _nextLevel.text = data.nextLevel;
            addChild(_nextLevel);
         }
         else if(_nextLevel.parent)
         {
            removeChild(_nextLevel);
         }
      }
   }
}
