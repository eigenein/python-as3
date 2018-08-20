package game.data.storage.arena
{
   import com.progrestar.common.util.assert;
   
   public class ArenaDescriptionStorage
   {
       
      
      public const arena:ArenaDescription = new ArenaDescription();
      
      public const grand:ArenaDescription = new ArenaDescription();
      
      public const EMPTY_REWARD_DESCRIPTION:ArenaRewardDescription = new ArenaRewardDescription({});
      
      private var rewards:Vector.<ArenaRewardDescription>;
      
      public function ArenaDescriptionStorage()
      {
         super();
      }
      
      public function init(param1:*) : void
      {
         var _loc3_:* = param1.type;
         assert(param1 && param1.type && param1.reward);
         arena.init(_loc3_.arena);
         grand.init(_loc3_.grand);
         rewards = new Vector.<ArenaRewardDescription>(0);
         var _loc5_:int = 0;
         var _loc4_:* = param1.reward;
         for each(var _loc2_ in param1.reward)
         {
            rewards.push(new ArenaRewardDescription(_loc2_));
         }
      }
      
      public function getRewardByPlace(param1:int) : ArenaRewardDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getRewardList() : Vector.<ArenaRewardDescription>
      {
         var _loc1_:Vector.<ArenaRewardDescription> = new Vector.<ArenaRewardDescription>();
         _loc1_ = rewards.slice();
         return _loc1_;
      }
   }
}
