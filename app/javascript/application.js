// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery";

function loadUsers(url) {
  $.ajax({
    url: url,
    method: 'GET',
    success: function(response) {
      $('#users-list').empty();
      response.forEach(function(user) {
        let campaigns = user.campaigns_list
          .map(c => {
            const campaignName = c.campaign_name || 'N/A';
            const campaignId = c.campaign_id || 'N/A';
            return `${campaignName} (${campaignId})`;
          })
          .join(', ');
        $('#users-list').append(`<tr><td>${user.name}</td><td>${user.email}</td><td>${campaigns}</td></tr>`);
      });
    },
    error: function(error) {
      console.error('Error fetching users:', error);
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  loadUsers('/api/v1/users');

  $('#campaign-filter-form').submit(function(event) {
    event.preventDefault();
    var campaignNames = $('#campaign-filter').val().trim();

    let url = '/api/v1/users/filter';

    if (campaignNames) {
      url += `?campaign_names=${campaignNames}`;
    }
    loadUsers(url);
  });

  $('#add_user_btn').on('click', function() {
    window.location = "/users/new";
  });

  $('#new_user_form').on('submit', function(event) {
    event.preventDefault();

    let formData = $(this).serializeArray();

    $.ajax({
      url: '/api/v1/users',
      method: 'POST',
      data: formData,
      success: function() {
        alert('User created successfully!');
        setTimeout(function() {
          window.location = "/users";
      }, 1000);
      },
      error: function(response) {
        alert('Error creating user: ' + response.responseText);
        setTimeout(function() {
          window.location = "/users";
      }, 1000);
      }
    });
  });
});
