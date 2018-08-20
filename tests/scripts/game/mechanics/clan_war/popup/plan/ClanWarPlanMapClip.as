package game.mechanics.clan_war.popup.plan
{
   import com.progrestar.framework.ares.core.Node;
   import game.mechanics.clan_war.popup.war.ClanWarMapClip;
   import starling.filters.ColorMatrixFilter;
   
   public class ClanWarPlanMapClip extends ClanWarMapClip
   {
       
      
      public function ClanWarPlanMapClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.adjustSaturation(-0.5);
         ground_anim.graphics.filter = _loc2_;
      }
   }
}
