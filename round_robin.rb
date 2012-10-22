#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/helper'

players = Prisoner.subclasses
scores = Hash.new(0)

players.each do |player|
  nickname = player.nickname
  
  players.each do |opponent|
    scores[nickname] += PD.run([player, opponent]).first
  end
end

scores.keys.sort{ |a,b| scores[a] <=> scores[b] }.each do |nickname|
  puts sprintf('%5d %s', scores[nickname], nickname)
end