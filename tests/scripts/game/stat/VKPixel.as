package game.stat
{
   import battle.BattleStats;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import game.data.storage.level.PlayerTeamLevel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.quest.PlayerQuestEntry;
   
   public class VKPixel
   {
      
      private static var _instance:VKPixel;
       
      
      private var player:Player;
      
      public function VKPixel(param1:Player)
      {
         super();
         this.player = param1;
         _instance = this;
         var _loc2_:String = "VK.Retargeting.Init(\'VK-RTRG-126425-450JP\');";
         ExternalInterfaceProxy.call("(function(){" + _loc2_ + "})");
         send("login_complete");
         param1.heroes.signal_heroLeveledUp.add(handler_heroLeveledUp);
         param1.heroes.signal_heroEvolveStar.add(handler_heroEvolveStar);
         param1.heroes.signal_newHeroObtained.add(handler_heroObtained);
         param1.heroes.signal_heroPromoteColor.add(handler_heroPromote);
         param1.levelData.signal_levelUp.add(handler_levelUp);
         param1.questData.signal_questFarmed.add(handler_questFarm);
      }
      
      public static function send(param1:String) : void
      {
         if(!_instance)
         {
            return;
         }
         var _loc2_:String = "VK.Retargeting.Event(\'" + param1 + "\'); console.log(\'" + param1 + "\');";
         ExternalInterfaceProxy.call("(function(){" + _loc2_ + "})");
      }
      
      public static function init(param1:Player) : void
      {
         if(_instance)
         {
            return;
         }
         return;
         §§push(new VKPixel(param1));
      }
      
      private function handler_heroLeveledUp(param1:PlayerHeroEntry) : void
      {
         if(param1.level.level >= 5)
         {
            send("hero_level_up:" + param1.id + ":" + int(param1.level.level / 5) * 5);
         }
      }
      
      private function handler_heroObtained(param1:PlayerHeroEntry) : void
      {
         send("hero_obtain:" + param1.id);
      }
      
      private function handler_levelUp(param1:PlayerTeamLevel) : void
      {
         send("team_level:" + player.levelData.level.level);
      }
      
      private function handler_heroEvolveStar(param1:PlayerHeroEntry, param2:BattleStats, param3:int) : void
      {
         send("hero_evolve:" + param1.id + ":" + param1.star.star.id);
      }
      
      private function handler_heroPromote(param1:PlayerHeroEntry, param2:int) : void
      {
         send("hero_promote:" + param1.id + ":" + param1.color.color.id);
      }
      
      private function handler_questFarm(param1:PlayerQuestEntry) : void
      {
         send("quest_farm:" + param1.desc.id);
      }
   }
}
