# Data, Context and Interaction (DCI) is a paradigm used in computer software to
# program systems of communicating objects. Its goals are:
#
# * To improve the readability of object-oriented code by giving system behavior
# first-class status;
#
# * To cleanly separate code for rapidly changing system behavior (what the system does)
# from code for slowly changing domain knowledge (what the system is), instead
# of combining both in one class interface;
#
# * To help software developers reason about system-level state and behavior
# instead of only object state and behavior;
#
# * To support an object style of thinking that is close to peoples' mental
# models, rather than the class style of thinking that overshadowed object
# thinking early in the history of object-oriented programming languages.
#
# The paradigm separates the domain model (data) from use cases (context) and roles
# that objects play (interaction). DCI is complementary to model–view–controller (MVC).
# MVC as a pattern language is still used to separate the data and its processing from
# presentation.
#
# DCI was invented by Trygve Reenskaug, also the inventor of MVC. The current formulation
# of DCI is mostly the work of Reenskaug and James O. Coplien.
#
#     acct1 = Account.new(10500)
#     acct2 = Account.new(10010)
#
#     Balance::Transfer.new(acct1, acct2).transfer(50)
#
module DCI
end

require 'dci/object'  # data
require 'dci/context' # context
require 'dci/role'    # interation


