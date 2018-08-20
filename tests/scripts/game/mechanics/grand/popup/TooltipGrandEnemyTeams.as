package game.mechanics.grand.popup
{
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.DisplayObjectContainer;
   
   public class TooltipGrandEnemyTeams extends TooltipTextView
   {
       
      
      private var teams:Vector.<TooltipGrandEnemyTeamClip>;
      
      public function TooltipGrandEnemyTeams()
      {
         teams = new Vector.<TooltipGrandEnemyTeamClip>();
         super();
      }
      
      override protected function createElements() : void
      {
         super.createElements();
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc3_ = param1.tooltipVO.hintData;
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc6_ = _loc3_.getTeam(_loc5_);
               if(_loc6_.length > 0)
               {
                  if(_loc4_ >= teams.length)
                  {
                     teams[_loc4_] = AssetStorage.rsx.popup_theme.create_tooltip_grand_enemy_team();
                     addChild(teams[_loc4_].graphics);
                  }
                  else
                  {
                     teams[_loc4_].graphics.visible = true;
                  }
                  teams[_loc4_].team.setUnitTeam(_loc6_);
                  teams[_loc4_].tf_label.text = String(_loc4_ + 1);
                  _loc4_++;
               }
               else if(_loc5_ < teams.length)
               {
                  teams[_loc5_].graphics.visible = false;
               }
               _loc5_++;
            }
            if(_loc4_ == 3)
            {
               removeChild(_label);
            }
            else if(_loc4_ >= 0)
            {
               _loc7_ = DataStorage.rule.arenaRule.resolveGrandHideTopMessage(_loc4_);
               _label.text = _loc7_;
               if(_loc7_)
               {
                  addChild(_label);
               }
            }
            draw();
         }
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         layout = _loc1_;
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.padding = 20;
         _loc1_.gap = 20;
      }
   }
}
