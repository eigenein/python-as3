package game.view.popup.statistics
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BattleStatisticsPopupTeamClip extends GuiClipNestedContainer
   {
       
      
      private var mirrored:Boolean;
      
      public var hero_1:BattleStatisticsPopupTeamMemberClip;
      
      public var hero_2:BattleStatisticsPopupTeamMemberClip;
      
      public var hero_3:BattleStatisticsPopupTeamMemberClip;
      
      public var hero_4:BattleStatisticsPopupTeamMemberClip;
      
      public var hero_5:BattleStatisticsPopupTeamMemberClip;
      
      public var panels:Vector.<BattleStatisticsPopupTeamMemberClip>;
      
      public function BattleStatisticsPopupTeamClip(param1:Boolean)
      {
         super();
         this.mirrored = param1;
         hero_1 = new BattleStatisticsPopupTeamMemberClip(param1);
         hero_2 = new BattleStatisticsPopupTeamMemberClip(param1);
         hero_3 = new BattleStatisticsPopupTeamMemberClip(param1);
         hero_4 = new BattleStatisticsPopupTeamMemberClip(param1);
         hero_5 = new BattleStatisticsPopupTeamMemberClip(param1);
         panels = new <BattleStatisticsPopupTeamMemberClip>[hero_1,hero_2,hero_3,hero_4,hero_5];
      }
   }
}
